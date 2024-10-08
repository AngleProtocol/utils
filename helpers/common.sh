function chain_to_uri {
  chain=$1

  case $chain in
    "0")
      echo $ETH_NODE_URI_FORK
      ;;
    "1")
      echo $ETH_NODE_URI_MAINNET
      ;;
    "2")
      echo $ETH_NODE_URI_ARBITRUM
      ;;
    "3")
      echo $ETH_NODE_URI_POLYGON
      ;;
    "4")
      echo $ETH_NODE_URI_GNOSIS
      ;;
    "5")
      echo $ETH_NODE_URI_AVALANCHE
      ;;
    "6")
      echo $ETH_NODE_URI_BASE
      ;;
    "7")
        echo $ETH_NODE_URI_BSC
        ;;
    "8")
        echo $ETH_NODE_URI_CELO
        ;;
    "9")
        echo $ETH_NODE_URI_POLYGON_ZKEVM
        ;;
    "10")
        echo $ETH_NODE_URI_OPTIMISM
        ;;
    "11")
        echo $ETH_NODE_URI_LINEA
        ;;
    "12")
        echo $ETH_NODE_URI_MODE
        ;;
    "13")
        echo $ETH_NODE_URI_BLAST
        ;;
    "14")
        echo $ETH_NODE_URI_XLAYER
        ;;
    *)
      ;;
  esac
}

function chain_to_chainId {
  chain=$1

  case $chain in
    "0")
      echo "0"
      ;;
    "1")
      echo "1"
      ;;
    "2")
      echo "42161"
      ;;
    "3")
      echo "137"
      ;;
    "4")
      echo "100"
      ;;
    "5")
      echo "43114"
      ;;
    "6")
      echo "8453"
      ;;
    "7")
        echo "56"
        ;;
    "8")
        echo "42220"
        ;;
    "9")
        echo "1101"
        ;;
    "10")
        echo "10"
        ;;
    "11")
        echo "59144"
        ;;
    "12")
        echo "34443"
        ;;
    "13")
        echo "81457"
        ;;
    "14")
        echo "196"
        ;;
    *)
      ;;
  esac
}