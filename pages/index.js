import { useKryptoBirdz } from "@components/hooks";
import { useWeb3 } from "@components/providers";
import { BaseLayout } from "@components/ui";

const Home = () => {
  const { contract } = useWeb3();

  const kryptoSupply = useKryptoBirdz({ contract });

  return <h1>HOME</h1>;
};

export default Home;

Home.Layout = BaseLayout;
