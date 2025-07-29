# frozen_string_literal: true

RSpec.shared_examples "successful service operation" do |expected_message = nil|
  it "returns success result" do
    result = subject.call
    expect(result[:success]).to be true
    expect(result[:message]).to eq(expected_message) if expected_message
    expect(result[:resource]).to be_present if result.key?(:resource)
  end
end

RSpec.shared_examples "failed service operation" do |expected_error = nil|
  it "returns error result" do
    result = subject.call
    expect(result[:success]).to be false
    expect(result[:error_message]).to be_present
    expect(result[:error_message]).to include(expected_error) if expected_error
  end
end

RSpec.shared_examples "creator service" do |model_class, expected_message|
  it "creates a new record" do
    expect { subject.call }.to change { model_class.count }.by(1)
  end

  include_examples "successful service operation", expected_message
end
