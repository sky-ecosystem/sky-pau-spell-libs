// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

interface IBeaconLike {

    struct Config {
        address facet;
        Wire[]  wires;
    }

    struct Wire {
        bytes4 callSelector;
        bytes4 delegateSelector;
    }

    function setIntegration(bytes32 id, Config calldata config) external;

    function getConfig(bytes32 integrationId) external view returns (Config memory);

}
