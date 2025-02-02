use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction}

pub type MyRedeemer {
  msg: ByteArray,
}

validator my_script {
  mint(redeemer: MyRedeemer, policy_id: PolicyId, self: Transaction) {
    todo @"validator logic goes here"
  }

  else(_) {
    fail
  }
}
