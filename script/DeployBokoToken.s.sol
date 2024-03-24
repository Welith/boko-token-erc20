// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BokoToken} from "../src/BokoToken.sol";

contract DeployBokoToken is Script {
    BokoToken public bokoToken;
    uint256 public constant INITIAL_SUPPLY = 10000 ether;

    function run() external returns (BokoToken) {
        vm.startBroadcast();
        bokoToken = new BokoToken(INITIAL_SUPPLY);
        vm.stopBroadcast();

        return bokoToken;
    }
}
