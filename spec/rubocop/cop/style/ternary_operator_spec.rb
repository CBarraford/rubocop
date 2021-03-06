# encoding: utf-8

require 'spec_helper'

describe Rubocop::Cop::Style::MultilineTernaryOperator do
  subject(:cop) { described_class.new }

  it 'registers offence for a multiline ternary operator expression' do
    inspect_source(cop, ['a = cond ?',
                         '  b : c'])
    expect(cop.offences.size).to eq(1)
  end

  it 'accepts a single line ternary operator expression' do
    inspect_source(cop, ['a = cond ? b : c'])
    expect(cop.offences).to be_empty
  end
end

describe Rubocop::Cop::Style::NestedTernaryOperator do
  subject(:cop) { described_class.new }

  it 'registers an offence for a nested ternary operator expression' do
    inspect_source(cop, ['a ? (b ? b1 : b2) : a2'])
    expect(cop.offences.size).to eq(1)
  end

  it 'accepts a non-nested ternary operator within an if' do
    inspect_source(cop, ['a = if x',
                         '  cond ? b : c',
                         'else',
                         '  d',
                         'end'])
    expect(cop.offences).to be_empty
  end
end
