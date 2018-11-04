class BlockChainController < ApplicationController
  require 'block_chain'
  def mine
    block_chain = BlockChain.new
    last_block =  block_chain.last_block
    last_proof = last_block[:proof]

    proof =  block_chain.proof_of_word(last_block)

     block_chain.new_transaction(
      0,"node_identifier",1
    )
    previous_hash =  BlockChain.hash(last_block)
    block =  block_chain.new_block(proof: proof, previous_hash: previous_hash)
    response = {
      message: 'New block Fored',
      index: block[:index],
      transactions: block[:transactions],
      proof: block[:proof],
      previous_hash: block[:previous_hash]
    }

    render json: response, status: 200
  end

  def new_transaction
    block_chain = BlockChain.new

    transaction_params = params.permit(:sender, :recipient, :amount)
    index =  block_chain.new_transaction(
      transaction_params[:sender],
      transaction_params[:recipient],
      transaction_params[:amount]
    )
    render json: {message: "Transaction wil be added to block #{index}"}, status: 201

  end

  def full_chain
    response = BlockChain.new.to_json
    render json: response, status: 200
  end

end
