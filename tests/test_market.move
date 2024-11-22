#[test_only]
module preorder::test {
    use sui::test_scenario::{Self as ts, next_tx};
    use sui::coin::{mint_for_testing};
    use sui::sui::{SUI};

    use std::string::{Self, String};

    use preorder::helpers::init_test_helper;
    use preorder::preorder::{Self as order, Shop, Item, User, Installments, Admin};

    const ADMIN: address = @0xe;
    const TEST_ADDRESS1: address = @0xee;
    const TEST_ADDRESS2: address = @0xbb;

    #[test]
   //#[expected_failure(abort_code = 0x2::dynamic_field::EFieldDoesNotExist)]     
    public fun test1() {
        let mut scenario_test = init_test_helper();
        let scenario = &mut scenario_test;

        // create shop 
        next_tx(scenario, TEST_ADDRESS1);
        {
            let shop_name = string::utf8(b"shop");

            order::create_shop(shop_name, ts::ctx(scenario));
        };

        // add items to shop 
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let name = string::utf8(b"shop");
            let features = string::utf8(b"shop");
            let description = string::utf8(b"shop");
            let price: u64 = 1_000_000_000;

            order::add_items_to_shop(&mut shop, name, features, description, price, ts::ctx(scenario));

            ts::return_shared(shop);
        };

        // add items to shop 
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let itemid: u64 = 0;
            
            let newprice: u64 = 1_000_000_000;

            order::UpdatePrice(&mut shop, itemid, newprice, ts::ctx(scenario));

            ts::return_shared(shop);
        };

        ts::end(scenario_test);
    }


}