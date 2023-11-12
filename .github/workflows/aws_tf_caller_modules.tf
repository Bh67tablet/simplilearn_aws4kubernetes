name: awsTerraformCaller

on:
  workflow_dispatch:
  
jobs:
  s3:
    uses: ./.github/workflows/awsTerraformReusable.yml
    with:
      terraformPath: tf_modules/module0/*
    secrets:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_KEY: ${{ secrets.AWS_SECRET_KEY }}
        AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}

  module1:
    uses: ./.github/workflows/awsTerraformReusable.yml
    needs: s3
    with:
      terraformPath: tf_modules/module1/*
    secrets:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_KEY: ${{ secrets.AWS_SECRET_KEY }}
        AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}
