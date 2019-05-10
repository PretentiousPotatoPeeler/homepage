#! /bin/bash

if [ -z ${1+x} ]; 
then echo "Specify destination as first param"; 
else 
  echo 'building sass...'
  sass themes/hugo-journal/scss/journal.scss themes/hugo-journal/static/css/journal.css
  echo 'sass done! building hugo...'
  hugo --destination=$1
  echo 'hugo done!'
fi