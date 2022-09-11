// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DenialHack {
    fallback() external payable {
        // waste all the gas
    }
}

