workflow "Depkoy Worker {
  on = "push"
  resolves = ["cloudflare/serverless-action@master"]
}

action "Deploy Worker" {
  uses = "cloudflare/serverless-action@master"
  env = {
    CLOUDFLARE_ACCOUNT_ID = "ACCOUNT_ID"
    CLOUDFLARE_ZONE_ID = "ZONE_ID"
    CLOUDFLARE_AUTH_EMAIL = "hello@example.com"
    CLOUDFLARE_SCRIPT_NAME = "worker-script"
  }
  secrets = ["CLOUDFLARE_AUTH_KEY"]
}
