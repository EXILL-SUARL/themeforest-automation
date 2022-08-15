import * as github from '@actions/github'
import core, { info, setOutput, setFailed, getInput } from '@actions/core'
import 'dotenv/config'
import zlib from 'node:zlib'
import mkdirp from 'mkdirp'
import tar from 'tar-fs'
import { Readable, pipeline, finished } from 'node:stream'
import { v5 as uuidv5, v4 as uuidv4 } from 'uuid'

const token = process.env.TOKEN ?? getInput('token', { required: true })
const owner = process.env.OWNER ?? github.context.repo.owner
const repo = process.env.REPO ?? github.context.repo.repo
const ref = process.env.REF ?? github.context.ref
const tag = ref.replace('refs/tags/', '')
const outputPath = `${process.env.HOME}/${uuidv5(repo, uuidv4())}`
const outputFile = `${outputPath}/${tag}.tar.gz`

const octokit = github.getOctokit(token)

const getRelease = async () => {
  try {
    info(`Getting release by tag ${tag}.`)
    return await octokit.rest.repos.getReleaseByTag({ owner, repo, tag })
  } catch (err) {
    setFailed(`${err}`)
  }
}

const getReleaseAsset = async () => {
  try {
    return await octokit.rest.repos.downloadTarballArchive({
      owner,
      repo,
      ref,
    })
  } catch (err) {
    setFailed(`${err}`)
  }
}

;(async function () {
  console.log(await getReleaseAsset())
  const assetBuffer = (await getReleaseAsset()
    .then((res) => res?.data)
    .catch()) as any
  mkdirp(outputPath)
    .then(async () => {
      const buffer = Buffer.from(assetBuffer)
      const stream = Readable.from(buffer)
      await pipeline(
        stream,
        // @ts-ignore Because: https://nodejs.org/api/zlib.html#class-zlibzlibbase
        zlib.Unzip(),
        tar.extract(outputPath, {
          strip: 1,
        }),
        (err) => {
          if (err) {
            throw err
          }
        },
      )
      finished(stream, (err) => {
        if (err) throw err
      })
    })
    .catch((err) => setFailed(err))
})()
