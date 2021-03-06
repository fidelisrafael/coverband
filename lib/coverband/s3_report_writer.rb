class S3ReportWriter

  def initialize(bucket_name)
    @bucket_name = bucket_name
  end

  def persist!
    object.put(body: coverage_content)
  end

  private

  def coverage_content
    File.read("#{SimpleCov.coverage_dir}/index.html").gsub("./assets/#{Gem::Specification.find_by_name('simplecov-html').version.version}/", '')
  end

  def object
    bucket.object('coverband/index.html')
  end

  def s3
    Aws::S3::Resource.new
  end

  def bucket
    s3.bucket(@bucket_name)
  end


end
