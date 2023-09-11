# Greetings - A Serverless "Hello World" API

## Overview

Simple serverless API that returns a "Hello World" message.

## Tech-Stack

- **Cloud Provider**: AWS
- **Programming Language**: Node.js
- **Testing Framework**: Jest
- **CI/CD**: GitHub Actions
- **IaC**: Serverless Framework / Terraform (TBD)

## High-Level Plan (To-Do List)

### Planning and Setup
- [x] Go with AWS as cloud provider?
- [x] Select a Framework (using NodeJS and TS)
- [x] Initialize Project

### Development
- [x] Install Required Libraries
- [x] Create the API
- [x] Select a Testing Framework
- [x] Write Tests

### Infrastructure & CI/CD Pipeline 
- [ ] Write IaC Code
- [ ] Select CI/CD Tool
- [ ] Write Pipeline-as-Code

### Deployment
- [x] Deploy Locally for Testing (localstack?) <- used [SAM CLI](https://aws.amazon.com/blogs/compute/aws-sam-support-for-hashicorp-terraform-now-generally-available/) 
- [x] Deploy to Cloud
- [ ] Test Cloud Deployment

### Scaling and Optimization
- [ ] Consider Scalability paths
- [ ] Monitor and Optimize
- [ ] additional steps to cover...?

### Documentation and Cleanup
- [ ] Document the Project
- [ ] Code Cleanup and Final Review


## How to Setup and Run

To Run the project locally, you need to have the following installed:
- nvm install
- yarn install
- yarn build

- To invoke the lambda locally:
  - install [SAM cli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)
  - `yarn build`
  - `cd infra/greetings`
  - run `sam local invoke --event __test/greet-event.json`

- to deploy to AWS:
  - `yarn bundle`
  - `cd infra/greetings`
  - run `terraform plan -out tfplan`, check the plan and then run `terraform apply tfplan`
  - run `sam deploy --guided`
  - run `sam deploy --guided`

## Project Structure

TBD

