# Create an FTP account and mount it to AWS s3 with the rest API

This is nodejs API service for creating FTP user accounts on a Linux environment and an FTP data directory will mount on the AWS s3 bucket. Data will sync between the Linux instance and s3 bucket bidirectional. When creating an FTP account user details are also saved on the SQLite database in the project directory and it will help to prevent creating a duplicate entry on the FTP server
 <br /> <br />

# Table of Contents 
- [Create an FTP account and mount it to AWS s3 with the rest API](#create-an-ftp-account-and-mount-it-to-aws-s3-with-the-rest-api)
- [Table of Contents](#table-of-contents)
- [Environment](#environment)
- [FTP-user create bash script](#ftp-user-create-bash-script)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
  - [POST /api/user/](#post-apiuser)
- [Usage](#usage-1)
- [Project Status](#project-status)
- [Room for Improvement](#room-for-improvement)
- [Acknowledgement](#acknowledgement)
- [Contact](#contact)
<!-- * [License](#license) -->

# Environment

 First you need to set up a Linux environment with the below requirements

 * Install FTP Server ON AWS LINUX  <br />
   https://medium.com/tensult/configure-ftp-on-aws-ec2-85b5b56b9c94

 * Install AWS CLI on your Linux instance if you are using Amazon Linux this step is not required  https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

 * Run AWS configure and provide your access details  
    `aws configure`

 * Install s3fs-fuse  <br />
   this is used for mount S3 on ec2  <br />
  https://github.com/s3fs-fuse/s3fs-fuse

  #  FTP-user create bash script

create this group on your Linux instance before running the script

  ` sudo groupadd sftpusers`

This Linux bash script `ftp-user-create.sh` will create the user account on the FTP account and directory on the s3 bucket, finally add the mounting location to the Linux fstab for automatically mount a directory on an instance when it starts. make sure to provide execution permission for the bash script.


For debug/test the bash script you can run it manually with test data 

`./ftp-user-create.sh user password "" "" s3 bucket-name ap-south-1 1`


# Prerequisites

For Windows

* Python 2.7 (for Microsoft build tools)
* Install Microsoft build tools (to build SQLite using node-gyp)
  * Instructions here https://github.com/nodejs/node-gyp#on-windows
  * Or install using npm (`npm install --global windows-build-tools`)
* Node-gyp (`npm install --global node-gyp`)



# Usage

* Run `npm install` to install dependencies
* Run `npm run start` to start the local server
* Load `http://localhost:8000` to test the endpoint. It will display a JSON result `{"message":"Ok"}`


# API Endpoints

To create an FTP account call this rest API with valid data it will create the account and mount it on the s3 bucket check node app logs for errors
<!-- ## GET /api/users

Get a list of users

```json
{
  "message": "success",
  "data": [
    {
      "id": 1,
      "name": "admin",
      "email": "admin@example.com",
      "password": "a66abb5684c45962d887564f08346e8d"
    },
    {
      "id": 2,
      "name": "user",
      "email": "user@example.com",
      "password": "4da49c16db42ca04538d629ef0533fe8"
    }
  ]
}
```

## GET /api/user/{id}

Get user information by user id

```json
{
  "message": "success",
  "data": {
    "id": 1,
    "name": "admin",
    "email": "admin@example.com",
    "password": "a66abb5684c45962d887564f08346e8d"
  }
}
```
 -->
## POST /api/user/

To create a new user based on POST data (x-www-form-url-encoded)

* name: User name           (ftp user name)
* password: User password   (ftp user password)
* bucket: S3 Bucket Name

Headers

* token: security token based on the environment </br>
  default token : `SHDXE5EL5E9ED` (hardcoded in server.js change it when you deploy )

The success result is:

```json
{
    "message": "success",
    "data": {
        "name": "ftp-user",
        "bucket": "ftp-bucket",
        "path": "ftp-bucket/ftp-user"
    },
    "id": 21
}
```

The error result is:

```json
{
    "message": "error",
    "error": "User Alrady Exist"
}
```



<!-- ## PATCH /api/user/{id}

To update user data by id, based on POST data (x-www-form-url-encoded)

* name: User name
* email: User email
* password: User password

You can send only one attribute to update, the rest of the info remains the same. 

In this example, using CURL you can update the user email:

```bash
curl -X PATCH -d "email=user@example1.com" http://localhost:8000/api/user/2
```

## DELETE /api/user/{id}

To remove a user from the database by user id. 

This example is using the `curl` command line


```bash
curl -X "DELETE" http://localhost:8000/api/user/2
```

The result is:

`{"message":"deleted","rows":1}` -->

# Usage
You can use this project to create an FTP account on a Linux server and mount it to AWS s3 specially in some scenarios we have to create FTP accounts in our information systems and provide them to users this is good for that kind of use case

`write-your-code-here`

# Project Status
Project is: completed but has many features to add.


# Room for Improvement
Below points can be considered as improvements in this project

Room for improvement:
- Security improvements ( add some authentication layer )
- APIs to update the view and delete user accounts
- Web portal to view details
- Setup another DBMS
- Add docker to project


# Acknowledgement
Give credit here.
- This project was inspired by https://www.sketchdev.io/blog/set-up-an-sftp-server-backed-by-s3-on-aws
- This project was used on  https://github.com/s3fs-fuse/s3fs-fuse



# Contact
Created by [@chathunbandara](https://www.chathunz.com/) - feel free to contact me!


<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->








