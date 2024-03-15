output "s3_4_codepipeline_artifacts" {
  value = module.s3_4_codepipeline_artifacts[*]
}
output "s3_4_codebuild_logs" {
  value = module.s3_4_codebuild_logs[*]
}
