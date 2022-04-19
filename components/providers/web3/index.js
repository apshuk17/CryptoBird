import { createContext, useState, useEffect, useContext, useMemo } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import { useAccount, useNetwork } from "@components/hooks";
import { loadContract } from "@utils/loadContract";

const Web3Context = createContext(null);

const Web3Provider = ({ children }) => {
  const [web3Api, setWeb3Api] = useState({
    web3: null,
    provider: null,
    contract: null,
    isLoading: true,
  });

  const { web3, provider, isLoading } = web3Api;

  const { data: accountConnected } = useAccount({ web3, provider });

  const { networkName: networkConnected, networkId } = useNetwork({
    web3,
    provider,
  });

  useEffect(() => {
    const loadProvider = async () => {
      try {
        let provider = await detectEthereumProvider();
        const web3 = new Web3(provider);
        const contract = await loadContract({contractName: "KryptoBird", web3});
        setWeb3Api((prevState) => ({
          ...prevState,
          web3,
          provider,
          contract,
          isLoading: false,
        }));
      } catch (error) {
        console.log("Please install Metamask!");
        setWeb3Api((prevState) => ({ ...prevState, isLoading: false }));
      }
    };

    loadProvider();
  }, []);

  const _web3Api = useMemo(() => {
    return {
      ...web3Api,
      requireInstall: !isLoading && !web3,
      accountConnected,
      networkConnected,
      networkId,
    };
  }, [web3Api, accountConnected, web3, isLoading, networkConnected, networkId]);

  return (
    <Web3Context.Provider value={_web3Api}>{children}</Web3Context.Provider>
  );
};

export default Web3Provider;

export const useWeb3 = () => useContext(Web3Context);
