If `curl` works fine for downloading the package but `npm install` reports a **certificate issue**, the problem may lie in how Node.js and NPM handle SSL certificates. Here are some troubleshooting steps and potential fixes:

---

### 1. **Verify Node.js Trust Store**
Node.js and NPM use their own certificate store, which may not include your custom or corporate CA (Certificate Authority). If your organization uses custom certificates, ensure they are properly added to Node.js's trusted certificate store.

#### Steps:
1. Locate your custom CA certificate file (e.g., `custom-ca.crt`).
2. Add it to the Node.js environment:
   ```bash
   export NODE_EXTRA_CA_CERTS=/path/to/custom-ca.crt
   ```
3. Run your `npm install` command again:
   ```bash
   npm install
   ```

---

### 2. **Disable Strict SSL Temporarily**
If you’re confident the issue is related to the certificate but want a quick workaround, you can disable strict SSL verification temporarily for npm:

```bash
npm config set strict-ssl false
```

Then try installing the package:
```bash
npm install pdf-viewer
```

> **Note**: This is **not recommended** for production environments or long-term use, as it bypasses SSL verification.

---

### 3. **Check NPM Configuration for CA**
Ensure that the NPM client is aware of your custom certificate. Add it to your NPM configuration:

1. Locate your custom CA certificate file (e.g., `custom-ca.crt`).
2. Add it to `.npmrc`:
   ```plaintext
   cafile=/path/to/custom-ca.crt
   ```
3. Run your installation again:
   ```bash
   npm install pdf-viewer
   ```

---

### 4. **Test the SSL Chain with OpenSSL**
Use `openssl` to test whether the SSL certificate chain is complete and valid:

```bash
openssl s_client -connect asia-south1-npm.pkg.dev:443 -showcerts
```

- Look for any issues with the certificate chain.
- If there are missing intermediate certificates, add them to your trusted CA bundle.

---

### 5. **Update NPM and Node.js**
Sometimes outdated versions of Node.js or NPM cause certificate issues. Update both to the latest versions:

```bash
npm install -g npm
nvm install --lts
```

---

### 6. **Debug NPM with Verbose Logging**
Run `npm install` with verbose logging to get more details about the certificate issue:

```bash
npm install pdf-viewer --verbose
```

Look for error messages related to SSL or certificates, which can provide further insight.

---

### 7. **Corporate Firewall or Proxy**
If you’re behind a corporate firewall or proxy, ensure that:
- The proxy is correctly configured in `.npmrc`.
- The proxy allows connections to `asia-south1-npm.pkg.dev`.

Add proxy settings to `.npmrc` if needed:
```plaintext
proxy=http://your-proxy:port
https-proxy=http://your-proxy:port
```

---

### 8. **Force npm to Use Curl's CA**
You can copy the CA bundle used by `curl` to Node.js:

1. Locate the CA file used by `curl`:
   ```bash
   curl-config --ca
   ```
2. Set the CA file for Node.js:
   ```bash
   export NODE_EXTRA_CA_CERTS=$(curl-config --ca)
   ```

Then retry the `npm install` command.

---

If none of these steps resolve the issue, please share the exact error message you see with `npm install --verbose`. This will help pinpoint the root cause of the certificate issue.




If `curl-config --ca` is not available on your system, here are a few alternative methods to locate the CA file used by `curl`:

---

### 1. **Check the Default CA Bundle Location**
`curl` typically uses a CA bundle provided by the operating system. You can find it at one of these common locations:

#### For Linux:
- `/etc/ssl/certs/ca-certificates.crt`
- `/etc/pki/tls/certs/ca-bundle.crt`
- `/etc/ssl/ca-bundle.pem`

#### For macOS:
- `/private/etc/ssl/cert.pem`
- `/System/Library/OpenSSL/certs`

#### For Windows:
On Windows, `curl` often relies on the system's certificate store, but it can be configured to use a specific CA file if needed.

---

### 2. **Query the `curl` Build Info**
Run the following command to see where your `curl` installation is configured to find the CA file or bundle:

```bash
curl --version
```

Look for a line like this in the output:

```plaintext
SSL: OpenSSL/1.x.x
CAfile: /path/to/ca-bundle.crt
```

The `CAfile` path will tell you where the CA bundle is located.

---

### 3. **Inspect `/etc/curl` or `/etc/ssl`**
If the above methods don’t help, manually check for `curl` configuration files. These directories often include the CA file:

```bash
ls /etc/curl*
ls /etc/ssl*
```

Look for files like `ca-certificates.crt`, `ca-bundle.crt`, or `cert.pem`.

---

### 4. **Download Mozilla’s CA Bundle**
If you can’t find the CA bundle on your system, you can download the Mozilla CA bundle, which is widely used:

1. Download the latest CA bundle from [curl’s website](https://curl.se/ca/cacert.pem).
   ```bash
   wget https://curl.se/ca/cacert.pem -O cacert.pem
   ```

2. Use this bundle with Node.js by setting the `NODE_EXTRA_CA_CERTS` environment variable:
   ```bash
   export NODE_EXTRA_CA_CERTS=/path/to/cacert.pem
   ```

---

### 5. **Directly Use `openssl`**
If none of the above works, you can use `openssl` to fetch and save the root certificates manually:

1. Connect to the Artifact Registry endpoint:
   ```bash
   openssl s_client -connect asia-south1-npm.pkg.dev:443 -showcerts
   ```
2. Copy the full certificate chain and save it to a `.crt` file (e.g., `artifact-registry.crt`).
3. Use this `.crt` file with Node.js or add it to your system’s CA store.

---

Let me know if you need further guidance!