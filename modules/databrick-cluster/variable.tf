variable "databrick_cluster_name" {
    description = "DataBrick Cluster Name"
    type = string
}

variable "tags" {
    description = "tags"
    type = map(string)
  
}

variable "spark_version" {
  description = "databrick spark  version"
  type = string
}

variable "node_type_id" {
    description = "databrick node type"
    type = string
  
}