# 1: Building kickoff trigger

The first part of the system is the kickoff. This is an endpoint that will be
called by the deploy script. In the future we'll have this take an argument, which
we can use to select URLs.

The main purpose of the gateway/lambda is to fetch URLs from GOV.UK search and
queue separate jobs for everything.

Learned:

- You need to give the lambda access to cloudwatch, otherwise you won't see logs. [Url of fix]
- SNS needs to be able to execute the lambda, otherwise nothing will happen. Use the error queue to debug this.
- Gateways need a "response method" set up. Takes way more code to set up than a rack app.

Choices in setup:

- `rake url`
- A central build script
- Use a separate `tf-config` directory for the terraform files. This keeps the
  root directory clean.

# 2: Screenshot queue

https://serverless.com/blog/building-a-serverless-screenshot-service-with-lambda/
