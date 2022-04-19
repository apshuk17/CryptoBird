import { Navbar } from '@components/ui';
import 'bootstrap/dist/css/bootstrap.css';
import "../styles/globals.css";

const Noop = ({ children }) => <>{children}</>;

function MyApp({ Component, pageProps }) {
  const Layout = Component.Layout ?? Noop;
  return (
    <Layout>
      <Navbar />
      <Component {...pageProps} />
    </Layout>
  );
}

export default MyApp;
