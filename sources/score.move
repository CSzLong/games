module games::score {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{TxContext, sender};

    struct Score has drop {}

    fun init(witness: Score, ctx: &mut TxContext) {
        transfer::transfer(coin::create_currency(
            witness, 9, ctx), sender(ctx));
    }

    public entry fun mint(cap: &mut  TreasuryCap<Score>, amount: u64, ctx: &mut TxContext) {
        transfer::transfer(coin::mint(cap, amount, ctx), sender(ctx));
    }
    
    public entry fun mint_to(cap: &mut  TreasuryCap<Score>, amount: u64, to: address, ctx: &mut TxContext) {
        transfer::transfer(coin::mint(cap, amount, ctx), to);
    }
}