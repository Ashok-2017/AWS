AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: SAM Template
Parameters:
  ArtifactsBucket:
    Type: 'AWS::SSM::Parameter::Value<String>'
    Default: 'ArtifactsBucket'
  RawBucketName: 
    Type: 'AWS::SSM::Parameter::Value<String>'
    Default: 'RawBucketName'
  ExchangeBucketName:
    Type: 'AWS::SSM::Parameter::Value<String>'
    Default: 'ExchangeBucketName'
  JarFileName:
    Type: 'AWS::SSM::Parameter::Value<String>'
    Default: '/artifacts/s3/path/Jar'
  Version:
    Type: 'AWS::SSM::Parameter::Value<String>'
    Default: '/VersionOfJar'
  Env:
    Type: String
    Description: prod/dev/stg
  RegionCode:
    Type: String
    Description: e.g. ue1 for us-east-1


Mappings:
  Environment:
    stg:
      Value: staging
    dev:
      Value: development
Resources:
  S3Update:
    Type: AWS::Serverless::Function
     Properties:
       FunctionName: !Sub "s3update-all"
       Handler: s3: handleRequest
       Runtime: Python3
       MemorySize: 512
       Description: S3Update
       CodeUri:
         Bucket: !Ref ArtifactsBucket
         Key: !Sub ${jarFileName}
       Role: !GetAtt s3update.Arn
       Environment: 
         Variables:
           GLOBAL_ENDPOINT_RELIGION: 
           HIST_RUN_TABLE: 
       Tags:
         version: !Sub ${Version}
         environment: !FindInMap
           - Environment
           - !Ref Env
           - Value
      
      
      
