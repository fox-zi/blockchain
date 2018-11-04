require 'digest'
class BlockChain
  def initialize
    @chain = Array.new
    @current_transactions = Array.new
    new_block(previous_hash: 1, proof: 100)
  end

  def new_block(proof:, previous_hash: nil)
    block = {
      index: @chain.length + 1,
      timestamp: Time.current,
      transactions: @current_transactions,
      proof: proof,
      previous_hash: previous_hash || self.class.hash(@chain[-1])
    }

    @current_transactions = Array.new
    @chain << block
    return block
    # Thêm một block vào chain
  end

  def new_transaction(sender, recipient, amount)
    p(sender, recipient, amount)
    @current_transactions << {
      sender: sender,
      recipient: recipient,
      amount: amount
    }
    return last_block[:index] + 1
    # Thêm một transaction vào list transaction
  end

  class << self
    def hash(block)
      # Trả về hash của một block
      Digest::SHA256.hexdigest(block.to_json)
    end

    def valid_proof(last_proof, proof)
      guess = "#{last_proof}#{proof}"
      guess_hash = Digest::SHA256.hexdigest(guess.to_json)
      return guess_hash[0..3] == "0000"
    end
  end

  def last_block
    @chain[-1]
    # Trả về block cuối trong chain
  end

  def proof_of_word(last_proof)
    proof = 0
    while !self.class.valid_proof(last_block, proof)
      proof += 1
    end
    proof
  end
end
