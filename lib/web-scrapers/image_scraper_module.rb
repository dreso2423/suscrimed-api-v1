module ImageScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape_ean("1234567890123")      # Fake EAN
  
  def self.scrape_ean(browser, ean)
    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean

    image_url = ImageScraperModule.scrape_ahorro(browser, ean)
    image_url = ImageScraperModule.scrape_farmalisto(browser, ean)  if image_url == ''
    image_url = 'Not Found'                                         if image_url == ''
    
    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'

    image_url
  end

  def self.scrape_ahorro(browser, ean)
    puts Time.now.to_s + ' Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    browser.img(class: 'product-image-photo').exists? ? browser.img(class: 'product-image-photo').src : ''
  end

  def self.scrape_farmalisto(browser,ean)
    puts Time.now.to_s + ' Scrapeando Farmalisto'
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    browser.div(class: 'df-header-title').wait_until(&:exists?)
    browser.a(class: 'df-card__main').exists? ? browser.a(class: 'df-card__main').img.src : ''
  end
end