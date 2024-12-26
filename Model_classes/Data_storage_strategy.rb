class Data_storage_strategy
  # read from file
  def from(file)
      raise NotImplementedError, 'Not implemented'
  end
  # write to file
  def to(students, file)
      raise NotImplementedError, 'Not implemented'
  end
end