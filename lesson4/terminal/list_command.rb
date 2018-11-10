class ListCommand < BaseCommand
  def run
    options[:objects].each { |obj| puts obj }
  end
end
