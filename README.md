# create instance keys
  ssh-keygen -f cicd
this generates public and private keys


## switch aws profile:
  export AWS_DEFAULT_PROFILE=[name]
### confirm aws profile:
  aws s3 ls

## tips
when we use s3 as backend terraform state, it is batter to switch on s3 bucket enable versioning