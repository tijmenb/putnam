set -e

terraform fmt tf-config
terraform apply tf-config
echo "The URL is:"
rake url
