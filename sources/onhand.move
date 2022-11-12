module games::onhand{
    
    use sui::object;
    use sui::object::UID;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    
    struct Subinventory has key, store{
        id: UID,
        segment1: u64,
        segment2: u64
    }
    
    struct Locator has key, store{
        id: UID,
        segment1: u64,
        segment2: u64,
        segment3: u64,
        segment4: u64
    }
    
    struct Onhand has key, store{
        id: UID,
        subinv: Subinventory,
        loc: Locator,
        item: u64,
        quantity: u64,
        uom: bool
    }

    fun init(ctx: &mut TxContext){

        let subinv = Subinventory{
            id: object::new(ctx),
            segment1: 0,
            segment2: 0
        };
        let loc = Locator{
            id: object::new(ctx),
            segment1: 0,
            segment2: 0,
            segment3: 0,
            segment4: 0
        };
        let onhand_init = Onhand{
            id: object::new(ctx),
            subinv: subinv,
            loc: loc,
            item: 0,
            quantity: 0,
            uom: false
        };
        transfer::transfer<Onhand>(onhand_init, tx_context::sender(ctx))
    }

    
    public fun new_onhand(subinv: Subinventory, loc: Locator, item: u64, qty: u64, uom: bool, ctx: &mut TxContext): Onhand{
    //public fun new_onhand(item: u64, qty: u64, uom: bool, ctx: &mut TxContext): Onhand{   
        Onhand{
            id: object::new(ctx),
            subinv: subinv,
            loc: loc,
            item: item,
            quantity: qty,
            uom: uom
        }
    }

    public entry fun create(item: u64, qty: u64, uom: bool, ctx: &mut TxContext){
        
        let subinv = Subinventory{
            id: object::new(ctx),
            segment1: 1,
            segment2: 1
        };
        let loc = Locator{
            id: object::new(ctx),
            segment1: 2,
            segment2: 2,
            segment3: 2,
            segment4: 2
        };
        
        let onhand_obj = new_onhand(subinv, loc, item, qty, uom, ctx);
        //let onhand_obj = new_onhand(item, qty, uom, ctx);
        transfer::transfer<Onhand>(onhand_obj, tx_context::sender(ctx))
    
    }
    
    public fun get_onhand(self: &Onhand): ( u64, u64, bool){
        (self.item, self.quantity, self.uom)
    }

    // #[test]
    // public fun test_get_onhand(){
            
    //     use sui::test_scenario::{Self, TxContext};
        
    //     let owner = @0x7497bdeec1916b3fd1e8660290e98c3cf671d607;
        
    //     let scenario_val = test_scenario::begin(owner);
        
    //     let scenario = &mut scenario_val;
        
    //     {
    //         init(test_scenario::ctx(scenario));
    //     };
        
        
    //     test_scenario::next_tx(scenario, xowner);
    //     let a = test_scenario::end(scenario_val);
    
    // }

    #[test]
    public fun test_create(){
        use sui::tx_context;

        let ctx = tx_context::dummy();
        
        let onhand = create(10, 100, true, ctx);
        let owner = @0x7497bdeec1916b3fd1e8660290e98c3cf671d607;

        transfer::transfer<Onhand>(onhand, owner);

    }

}