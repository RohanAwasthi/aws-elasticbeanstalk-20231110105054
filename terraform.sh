#!/bin/bash
cd Project

{
terraform init
} || {
curl -X POST -H 'Content-Type: application/json' -d '{"trackId": "12345", "status": "Error"}'  http://20.193.131.46:4001/api/v2/updatestatus
raise error "A- terraform init"
}
curl -X POST -H 'Content-Type: application/json' -d '{"trackId": "12345", "status": "InProgress"}'  http://20.193.131.46:4001/api/v2/updatestatus
{
terraform plan -var-file=terraform.tfvars
} || {
curl -X POST -H 'Content-Type: application/json' -d '{"trackId": "12345", "status": "Error"}'  http://20.193.131.46:4001/api/v2/updatestatus
error
}
{
terraform apply -var-file=terraform.tfvars -auto-approve
} || {
curl -X POST -H 'Content-Type: application/json' -d '{"trackId": "12345", "status": "Error"}'  http://20.193.131.46:4001/api/v2/updatestatus
error
}
curl -X POST -H 'Content-Type: application/json' -d '{"trackId": "12345", "status": "Success"}'  http://20.193.131.46:4001/api/v2/updatestatus