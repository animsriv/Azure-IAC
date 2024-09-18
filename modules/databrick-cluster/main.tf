resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "${var.databrick_cluster_name}"
  spark_version           = "${var.spark_version}"
  node_type_id            = "${var.node_type_id}"
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 10
  }
  tags = "${var.tags}"
}

