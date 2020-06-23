[![Build Status](https://travis-ci.com/scottselberg/auto-wiki-test.svg?branch=master)](https://travis-ci.com/scottselberg/auto-wiki-test)

# AutoWikiTest

## Introduction

This project is an example to automatically maintain the github wiki repo 
from a a *wiki* folder in the main repo. The value here is allowing the
development community to submit wiki change pull requests as that is allowed
for the main repo but not supported for the wiki repo.

## How it works

The core idea is to have a CI system copy the changes from the *wiki* folder
into the github wiki repo. For open source projects in github, [https://travis-ci.com](Travis-CI)
seems to be the way to go.

The [https://docs.travis-ci.com/user/tutorial](Travis CI Tutorial) was pretty
to follow. The main steps were linking my github account with a travis ci
account. Travis CI then found my repo automatically.

I then created a .travis.yml file to provide the instructions on what to do.  Travis CI
really wants to do a build for a particular language which I don't really have in this
example.  Since I plan to propose this for a way to maintain the wiki for the chordpro
project, I chose perl as the language.   

The one part of the travis recipe below that is not obvious is the setting of the
GITHUB_TOKEN variable.  This is not automatic.  You need to login into github and 
create a personal authentication token with write access to the repo.  Then in your
travis-ci repository settings, you setup the GITHUB_TOKEN environment variable.


```yaml
language: perl
os: linux
dist: trusty
env:
  global:
    - GITHUB_ORG="scottselberg"
    - EMAIL="saselberg2@gmail.com"
    - REPO="auto-wiki-test"
    - WIKI_REPO="${REPO}.wiki"
    - WIKI_FOLDER="wiki"
install: skip
stages:
  - name: WikiUpdate
jobs:
  include:
    - stage: WikiUpdate
      if: (branch = master) AND (type = push)
      script:
        # Move up one layer so we can see both the source
        # code repo and the wiki repo.
        - cd ..

        # Clone wiki repository.
        - git clone https://github.com/${GITHUB_ORG}/${WIKI_REPO}.git

        # Update wiki repository with documentation folder contents.
        - rsync -av --exclude=.git --delete ${REPO}/${WIKI_FOLDER}/ ${WIKI_REPO}/

        # Commit and push changes into the wiki repo
        - cd ${WIKI_REPO}
        - |
          git config user.email ${EMAIL}
          git config user.name ${USER}
          git add --all
          git status
          git commit -m "${REPO} wiki update | Travis CI build number $TRAVIS_BUILD_NUMBER"
          git remote add origin-wiki "https://${USER}:${GITHUB_TOKEN}@github.com/${GITHUB_ORG}/${WIKI_REPO}.g
          git push origin-wiki master
```
