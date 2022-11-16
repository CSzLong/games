module games::subinventory{

    use sui::object::{Self, ID, UID};
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    
    struct Organization has key, store{
        id: UID,
        name: String,
        code: String
    }

    struct Subinventory has key, store{
        id: UID,
        organization_id: ID,
        segment1: String,
        segment2: String
    }

    struct Locator has key, store{
        id: UID,
        subinv_id: ID,
        segment1: u64,
        segment2: u64,
        segment3: u64,
        segment4: u64
    }

}