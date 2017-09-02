class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if @sender.valid? && @receiver.valid? == true
      true
    elsif @sender.valid? && @receiver.valid? == false
      false
    end
  end

  def execute_transaction
    if @amount < @sender.balance && self.valid? && @status == "pending"
      @receiver.deposit(@amount)
      @sender.balance = @sender.balance - @amount
      @status = "complete"
    elsif @amount > @sender.balance
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.balance = @receiver.balance - @amount
      @status = "reversed"
    end
  end

end
