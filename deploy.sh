#!/bin/bash

echo "Generating site"
hugo

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master
git subtree push --prefix=public git@github.com:rprakashg/hugo_gh_blog.git gh-pages
