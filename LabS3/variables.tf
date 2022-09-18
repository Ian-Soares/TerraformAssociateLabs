variable "bucket_id" {
  type        = string
  default     = "labs3-iansoares"
  description = "The global unique id for the bucket"
}

variable "upload_directory" {
  type    = string
  default = "../frontend-example/"
}

variable "mime_types" {
  default = {
    htm   = "text/html"
    html  = "text/html"
    css   = "text/css"
    md    = "text/markdown"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    png   = "image/x-png"
    svg   = "image/svg+xml"
    jpg   = "image/jpeg"
  }
}