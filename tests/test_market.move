#[test_only]
module preorder::test {
    use sui::test_scenario::{Self as ts, next_tx};
    use sui::coin::{mint_for_testing};
    use sui::sui::{SUI};

    use std::string::{Self, String};
    use std::debug::print;

    use preorder::helpers::init_test_helper;
    use preorder::preorder::{Self as order, Shop, Item, User, Installments, Admin};

    const ADMIN: address = @0xe;
    const TEST_ADDRESS1: address = @0xee;
    const TEST_ADDRESS2: address = @0xbb;

   #[test]
   #[expected_failure(abort_code = preorder::preorder::EALREADYREGISTERED)]     
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

        // update price 
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let itemid: u64 = 0;
            
            let newprice: u64 = 1_000_000_000;

            order::UpdatePrice(&mut shop, itemid, newprice, ts::ctx(scenario));

            ts::return_shared(shop);
        };

        // search_item_in_store_by_name
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let itemid: u64 = 0;
            let name = string::utf8(b"shop");

            let (str1, str2, str3, u1, u2) = order::search_item_in_store_by_name(&mut shop, name, ts::ctx(scenario));

            print(&str1);
            print(&str2);
            print(&str3);
            print(&u1);
            print(&u2);

            ts::return_shared(shop);
        };

        // register_user
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let name = string::utf8(b"mentalist");

            order::register_user(&mut shop, name, ts::ctx(scenario));

            ts::return_shared(shop);
        };

        // register_user again
        next_tx(scenario, TEST_ADDRESS1);
        {
            let mut shop = ts::take_shared<Shop>(scenario);
            let name = string::utf8(b"mentalist");

            order::register_user(&mut shop, name, ts::ctx(scenario));

            ts::return_shared(shop);
        };

        ts::end(scenario_test);
    }


}