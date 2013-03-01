RSpec::Matchers.define :be_accessible_only do |*expected|
  match do |actual|
    m_a_a = actual.send :mass_assignment_authorizer, nil
    m_a_a.to_a.sort.reject(&:empty?) == expected.map(&:to_s).sort.reject(&:empty?)
  end

  failure_message_for_should do |actual|
    "actual accessible attributes #{actual.send(:mass_assignment_authorizer, nil).to_a.sort.join(' ')}"
  end
end