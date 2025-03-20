module FileFixture
  def file_fixture(fixture_name)
    file_fixture_path = FileFixture.file_fixture_path
    path = Pathname.new(File.join(file_fixture_path, fixture_name))

    if path.exist?
      path
    else
      msg = "the directory '%s' does not contain a file named '%s'"
      raise ArgumentError, msg % [file_fixture_path, fixture_name]
    end
  end

  def self.file_fixture_path
    @file_fixture_path ||= File.join(File.expand_path(File.dirname(__FILE__)), "..", "fixtures")
  end

  def self.file_fixture_path=(path)
    @file_fixture_path = path
  end
end
