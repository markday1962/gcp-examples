# gcp-examples
Repo for my GCP exampes

## Usefull Commands

### Compute
```
gcloud compute project describe
```

#### Instances
```
gcloud compute
gcloud compute instances
gcloud compute instances list
```
```
gcloud compute instances create test-instance-1 # If no zone specified takes the information from the project
gcloud compute zones list
gcloud compute instances create test-instance-2 --zone=europe-west1a
```
```
gcloud compute machine-types list
gcloud compute machine-types list --filter="name:c4-" --filter="name:c4- AND zone:(europe-west1-b OR europe-west1-c)"
gcloud compute instances create test-instance-3 --zone=europe-west1a \
--machine-type=e2-standard
```
```
gcloud compute disk-types list
gcloud compute instances create test-instance-4 --zone=europe-west1a \
--machine-type=e2-standard \
--boot-disk-types=ssd --boot-disk-size=100
```
```
gcloud compute instances create test-instance-5 --zone=europe-west1a \
--machine-type=e2-standard \
--boot-disk-types=ssd --boot-disk-size=100 \
--labels=k0=v0,k1=v1
gcloud compute instances list --zone=eu-west1a \
--filter='labels.k0:v0'
```
```
gcloud compute instances describe
gcloud compute instances describe test-instance-1 --zone=europe-west1a \
--format='default(labels)'
```
```
gcloud compute instances stop test-instance-1
gcloud compute instances start test-instance-1
gcloud compute instances delete test-instance-1 test-instance-2 test-instance-3 test-instance-4 test-instance-5
```

```
gcloud compute ssh --zone "europe-west2-a" "bastion-instance-template-20251230-161619" --tunnel-through-iap --project "bastion-with-iap"
```


### Cloud Storage

#### Object Storage
```
gcloud storage buckets create gs://markday-test-bucket-1 --location=EU-WEST-1\
--default-storage-class=STANDARD
```
