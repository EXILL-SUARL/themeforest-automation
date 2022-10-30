# Themforest-automation

[![Docker build](https://github.com/EXILL-SUARL/themeforest-automation/actions/workflows/docker-build.yml/badge.svg)](https://github.com/EXILL-SUARL/themeforest-automation/actions) [![Docker publish](https://github.com/EXILL-SUARL/themeforest-automation/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/EXILL-SUARL/themeforest-automation/actions) ![GitHub commits since latest release (by date including pre-releases)](https://img.shields.io/github/commits-since/EXILL-SUARL/themeforest-automation/latest?include_prereleases) [![GitHub license](https://img.shields.io/github/license/EXILL-SUARL/themeforest-automation)](https://github.com/EXILL-SUARL/themeforest-automation/blob/master/LICENSE)

This is a Docker container that automates boring and repetitive tasks that are part of [Envato's Themes Item Preparation & Technical Requirements](https://help.author.envato.com/hc/en-us/articles/360000470826-Themes-Item-Preparation-Technical-Requirements).

It is mainly utilized by [GitHub Actions](https://docs.github.com/en/actions) definded in our [private] repositories.

## Docker image

The image can be found at GitHub's Container Registry: https://github.com/orgs/EXILL-SUARL/packages/container/package/themeforest-automation.

## Usage with Github Actions

```yaml
name: Pre-release tasks
on:
  push:
    tags:
      - 'v*'
jobs:
  export-vars:
    runs-on: ubuntu-latest
    outputs:
      RELEASE_NAME: ${{ steps.vars.outputs.RELEASE_NAME }}
      TMP_DIR: ${{ steps.vars.outputs.TMP_DIR }}
      STRIPPED_ZIP_DIR: ${{ steps.vars.outputs.STRIPPED_ZIP_DIR }}
      STRIPPED_ZIP_NAME: ${{ steps.vars.outputs.STRIPPED_ZIP_NAME }}
      STRIPPED_ZIP: ${{ steps.vars.outputs.STRIPPED_ZIP }}
    steps:
      - name: Export variables
        run: |
          RELEASE_NAME=${{ github.event.repository.name }}-${{ github.ref_name }}
          TMP_DIR=/tmp/$RELEASE_NAME-tmp
          STRIPPED_ZIP_DIR=$TMP_DIR/to-deliver
          STRIPPED_ZIP_NAME=$RELEASE_NAME.zip
          echo "::set-output name=RELEASE_NAME::${{ github.event.repository.name }}-${{ github.ref_name }}"
          echo "::set-output name=TMP_DIR::$TMP_DIR"
          echo "::set-output name=STRIPPED_ZIP_DIR::$STRIPPED_ZIP_DIR"
          echo "::set-output name=STRIPPED_ZIP_NAME::$STRIPPED_ZIP_NAME"
          echo "::set-output name=STRIPPED_ZIP::$STRIPPED_ZIP_DIR/$STRIPPED_ZIP_NAME"
  process:
    runs-on: ubuntu-latest
    needs: [export-vars] # define prerequisite jobs
    outputs:
      # output-example: # define an output
    container:
      image: ghcr.io/exill-suarl/themeforest-automation:latest # it's recommended to use SemVer tags to avoid breaking changes
      env:
        TMP_DIR: ${{ needs.export-vars.outputs.TMP_DIR }}
    steps:
      - name: execute post-run # to update OS packages and install dependencies.
        run: post-run.sh
      - name: Clone project # clone a repository to process
        uses: actions/checkout@v3
      - name: Strip files
        run: globfile-del.sh ./.itemignore # delete every file/directory that match the defined glob paths in .itemignore
      - name: Generate documentation # generate documentation from a markdown file
        run: md-to-doc.sh ./documentation.md documentation
      - name: Blur ./public # batch-blur images in ./public directory
        run: batch-blur.sh ./public
      - name: ZIP CWD # export the current working directory as a ZIP
        run: dir-zip.sh . ${{ needs.export-vars.outputs.STRIPPED_ZIP_DIR }} ${{ needs.export-vars.outputs.STRIPPED_ZIP_NAME }}
      - name: upload stripped ZIP as an artifact
        uses: actions/upload-artifact@v3 # upload Artifact
        with:
          name: stripped-zip
          path: ${{ needs.export-vars.outputs.STRIPPED_ZIP }}
      - name: upload CWD as an artifact
        uses: actions/upload-artifact@v3 # upload Artifact
        with:
          name: stripped-directory
          path: ./
      - name: Send to FTP # upload processed files to an FTP server
        uses: SamKirkland/FTP-Deploy-Action@4.3.2
        with:
          local-dir: './'
          dangerous-clean-slate: false
          server: ${{ secrets.ftp_delivery_server }}
          username: ${{ secrets.ftp_delivery_username }}
          password: ${{ secrets.ftp_delivery_password }}
      - name: Download Artifact # download all previously uploaded Artifacts
        uses: actions/download-artifact@v3
```

#### More information on Github Action usage can be found at:

- https://docs.github.com/en/actions/using-jobs/running-jobs-in-a-container
- https://docs.github.com/en/actions
