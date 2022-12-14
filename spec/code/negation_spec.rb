require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    %w[!false true],
    %w[!!true true],
    %w[!!1 true],
    %w[+1 1],
    %w[+1.0 1.0],
    %w[+true true]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
