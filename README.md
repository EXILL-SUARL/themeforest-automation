# Themforest-automation

[![Docker test](https://github.com/EXILL-SUARL/themeforest-automation/actions/workflows/docker-test.yml/badge.svg)](https://github.com/EXILL-SUARL/themeforest-automation/actions) [![Docker publish](https://github.com/EXILL-SUARL/themeforest-automation/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/EXILL-SUARL/themeforest-automation/actions) ![GitHub commits since latest release (by date including pre-releases)](https://img.shields.io/github/commits-since/EXILL-SUARL/themeforest-automation/latest?include_prereleases) [![GitHub license](https://img.shields.io/github/license/EXILL-SUARL/themeforest-automation)](https://github.com/EXILL-SUARL/themeforest-automation/blob/master/LICENSE)

This is a Docker container that automates boring and repetitive tasks that are part of [Envato's Themes Item Preparation & Technical Requirements](https://help.author.envato.com/hc/en-us/articles/360000470826-Themes-Item-Preparation-Technical-Requirements).

It is mainly utilized by [GitHub Actions](https://docs.github.com/en/actions) definded in our [private] repositories.

## Docker image

The image can be found at GitHub's Container Registry: https://github.com/orgs/EXILL-SUARL/packages/container/package/themeforest-automation.

## Usage

Run a workflow:

```
$ runner <workflow_name> [arguments]
```

Run tests:

```
$ runner test
```

## Usage with Github Actions

```yaml
name: Pre-release tasks
on:
  workflow_dispatch:
    inputs:
      PRERELEASE:
        required: false
        type: string
      TAG:
        required: true
        type: string
jobs:
  prepare:
    runs-on: ubuntu-latest
    outputs:
      PRERELEASE: ${{ steps.vars.outputs.PRERELEASE }}
      FULLVERSION: ${{ steps.vars.outputs.FULLVERSION }}
      RELEASE_NAME: ${{ steps.vars.outputs.RELEASE_NAME }}
      TMPDIR: ${{ steps.vars.outputs.TMPDIR }}
      STRIPPED_ZIP_DIR: ${{ steps.vars.outputs.STRIPPED_ZIP_DIR }}
      STRIPPED_ZIP_NAME: ${{ steps.vars.outputs.STRIPPED_ZIP_NAME }}
      STRIPPED_ZIP: ${{ steps.vars.outputs.STRIPPED_ZIP }}
    steps:
      - name: Export vars # Export action environment variables
        id: vars
        run: |
          echo "PRERELEASE=${{ inputs.PRERELEASE }}" >> $GITHUB_OUTPUT
          echo "FULLVERSION=${{ inputs.TAG }}" >> $GITHUB_OUTPUT
          RELEASE_NAME=${{ github.event.repository.name }}-${{ inputs.TAG }}
          TMPDIR=/tmp/$RELEASE_NAME-tmp
          STRIPPED_ZIP_DIR=$TMPDIR/to-deliver
          STRIPPED_ZIP_NAME=$RELEASE_NAME.zip
          echo "RELEASE_NAME=${{ github.event.repository.name }}-${{ inputs.TAG }}" >> $GITHUB_OUTPUT
          echo "TMPDIR=$TMPDIR" >> $GITHUB_OUTPUT
          echo "STRIPPED_ZIP_DIR=$STRIPPED_ZIP_DIR" >> $GITHUB_OUTPUT
          echo "STRIPPED_ZIP_NAME=$STRIPPED_ZIP_NAME" >> $GITHUB_OUTPUT
          echo "STRIPPED_ZIP=$STRIPPED_ZIP_DIR/$STRIPPED_ZIP_NAME" >> $GITHUB_OUTPUT
      - uses: actions/checkout@v3.1.0 # Upload the clean repository checkout for later use
        with:
          ref: ${{ inputs.TAG }}
      - name: upload repository artifact
        uses: actions/upload-artifact@v3
        with:
          name: repository
          path: ./
  process:
    runs-on: ubuntu-latest
    needs: [prepare] # Define prerequisite jobs
    outputs:
      METADATA: ${{ steps.metadata.outputs.METADATA }} # Define an output
    container:
      image: ghcr.io/exill-suarl/themeforest-automation:latest # It's recommended to use SemVer tags to avoid breaking changes
      env:
        TMPDIR: ${{ needs.prepare.outputs.TMPDIR }}
    defaults:
      run:
        shell: bash -e {0} # Use Bash as the default Shell for this job
    steps:
      - uses: actions/download-artifact@v3 # Use the previously uploaded repository artifact
        with:
          name: repository
      - name: Import metadata # Parse JSONs for metadata purposes
        id: metadata
        run: |
          METADATA=$(metadata-parser.sh ./package.json ./.devcontainer/config/metadata.json)
          echo "METADATA=$METADATA" >> $GITHUB_OUTPUT
      - name: Generate documentation # Generate documentation from a markdown file
        run: runner md-to-doc.sh '${{ steps.metadata.outputs.METADATA }}' ./documentation.md documentation
      - name: Generate dependencies report # Generate dependencies report
        run: runner report-deps.sh .devcontainer/config/dependency_decisions.yml ./documentation
      - name: Blur /public # Blur all images in the public folder
        run: runner batch-blur.sh ./public
      - name: Ignore files # Delete every file/directory that matches the defined glob paths in .itemignore
        run: runner globfile-del.sh ./.itemignore
      - name: ZIP the CWD # Export the current working directory as a ZIP
        run: runner dir-zip.sh . ${{ needs.prepare.outputs.STRIPPED_ZIP_DIR }} ${{ needs.prepare.outputs.STRIPPED_ZIP_NAME }}
      - name: upload stripped item artifact # Upload for later delivery (as a ZIP file)
        uses: actions/upload-artifact@v3
        with:
          name: stripped-zip
          path: ${{ needs.prepare.outputs.STRIPPED_ZIP }}
      - name: upload stripped directory artifact # Upload for later delivery (as a directory)
        uses: actions/upload-artifact@v3
        with:
          name: stripped-directory
          path: ./
```

#### More information on Github Action usage can be found at:

- https://docs.github.com/en/actions/using-jobs/running-jobs-in-a-container
- https://docs.github.com/en/actions
