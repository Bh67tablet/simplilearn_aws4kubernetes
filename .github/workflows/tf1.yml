name: tf1

on:
  workflow_dispatch:
  
jobs:
  StateExample1:
    uses: ./.github/workflows/awsTerraformReusable.yml
    with:
      terraformPath: StateExample1/*
    secrets:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_KEY: ${{ secrets.AWS_SECRET_KEY }}
        AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}
    
  StateExample1c:
    uses: ./.github/workflows/awsTerraformReusable.yml
    needs: StateExample1
    with:
      terraformPath: StateExample1c/*
    secrets:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_KEY: ${{ secrets.AWS_SECRET_KEY }}
        AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}
