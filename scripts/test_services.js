const puppeteer = require('puppeteer');

async function testServices() {
  console.log('Starting tests of all services...');
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--ignore-certificate-errors'] // Ignore SSL errors for self-signed certs
  });

  try {
    // Test AutoGen service
    console.log('\n🔍 Testing AutoGen Studio...');
    const autogenPage = await browser.newPage();
    await autogenPage.goto('https://autogen.localhost', { waitUntil: 'networkidle2', timeout: 30000 });
    const autogenTitle = await autogenPage.title();
    console.log(`AutoGen page title: ${autogenTitle}`);
    
    // Take a screenshot
    await autogenPage.screenshot({ path: 'autogen-test.png' });
    console.log('AutoGen Studio screenshot saved to autogen-test.png');
    await autogenPage.close();

    // Test Open WebUI service
    console.log('\n🔍 Testing Open WebUI...');
    const webuiPage = await browser.newPage();
    await webuiPage.goto('https://webui.localhost', { waitUntil: 'networkidle2', timeout: 30000 });
    const webuiTitle = await webuiPage.title();
    console.log(`Open WebUI page title: ${webuiTitle}`);
    
    // Take a screenshot
    await webuiPage.screenshot({ path: 'webui-test.png' });
    console.log('Open WebUI screenshot saved to webui-test.png');
    await webuiPage.close();

    // Test All-Hands service
    console.log('\n🔍 Testing All-Hands...');
    const openhandsPage = await browser.newPage();
    await openhandsPage.goto('https://openhands.localhost', { waitUntil: 'networkidle2', timeout: 30000 });
    const openhandsTitle = await openhandsPage.title();
    console.log(`All-Hands page title: ${openhandsTitle}`);
    
    // Take a screenshot
    await openhandsPage.screenshot({ path: 'openhands-test.png' });
    console.log('All-Hands screenshot saved to openhands-test.png');
    await openhandsPage.close();

    console.log('\n✅ All tests completed successfully!');
  } catch (error) {
    console.error('❌ Error during testing:', error);
  } finally {
    await browser.close();
  }
}

testServices();