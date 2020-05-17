# what we use in this stack
1. EC2
2. IAM to attach EC2
  1. in the role, we have to attach AWSCodeDeployRole
3. Code deploy
4. Code Pipeline


# create instance keys
  ssh-keygen -f cicd
this generates public and private keys


## switch aws profile:
  export AWS_DEFAULT_PROFILE=[name]
### confirm aws profile:
  aws s3 ls

## tips
when we use s3 as backend terraform state, it is batter to switch on s3 bucket enable versioning