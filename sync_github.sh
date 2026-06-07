#!/bin/bash

git stash
git pull origin main --no-rebase
git stash pop
git add .
git commit -m "chore: sync remote and add local scripts"
git push origin main
