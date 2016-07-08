require File.dirname(__FILE__) + '/helper'

class TestI18nYamlSorter < Test::Unit::TestCase
  def test_should_sort_complex_sample_file
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_sort_complex_sample_file_with_special_characters
    open(File.dirname(__FILE__) + '/in_W.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_W.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_rails_i18n_default_file
    open(File.dirname(__FILE__) + '/in_rails.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_rails.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_sort_simple_text_file
    open(File.dirname(__FILE__) + '/in_simple.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_simple.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_not_alter_the_serialized_yaml
    #ordering should'n t change a thing, since hashes don't have order in Ruby
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      present = YAML::load(file.read)
      file.rewind
      future = YAML::load(sorter.sort)
      assert_equal present, future
    end
  end

  def test_command_line_should_work_in_stdin
    output = `#{File.dirname(__FILE__)}/../bin/sort_yaml < #{File.dirname(__FILE__)}/in.yml`
    open(File.dirname(__FILE__) +  '/out.yml') do |expected_out|
      assert_equal expected_out.read, output
    end
  end
end
