// SPDX-License-Identifier: MIT


//import "./SimpleStorage.sol";
//import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";
import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    //SimpleStorage public simpleStorage;
    SimpleStorage[] public listofSimpleStorageContracts;

    function createSimpleStorageContract() public {
        //simpleStorage = new SimpleStorage();
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listofSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore (uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {

        //address
        //ABI
        //SimpleStorage mySimpleStorageContract = listofSimpleStorageContracts[_simpleStorageIndex];
        //mySimpleStorageContract.store(_newSimpleStorageNumber);
        listofSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        //SimpleStorage mySimpleStorageContract = listofSimpleStorageContracts[_simpleStorageIndex];
        //return mySimpleStorageContract.retrieve();
        return listofSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }

}