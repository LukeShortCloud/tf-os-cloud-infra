# Terraform OpenStack Cloud Infrastructure (tf-os-cloud-infra)

Terraform module for deploying infrastructure with OpenStack to use for installing an OpenStack or OpenShift lab.

## Usage

Change the value of the variables to reflect the environment. Sample variables are provided.

```
$ vim variables.tf
```

Initalize the OpenStack provider.

```
$ terraform init
```

Apply the infrastructure changes.

```
$ terraform apply
```

## License

Apache Software License (ASL) v2.0.
