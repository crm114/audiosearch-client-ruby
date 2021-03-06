require 'spec_helper'

describe Audiosearch::Client do
  it "should initialize sanely" do
    client = get_client
  end

  it "should fetch root endpoint" do
    client = get_client
    resp = client.get('/')
    #puts pp( resp )
  end
end

describe "shows" do
  it "should fetch shows" do
    client = get_client

    show = client.get('/shows/74')
    #puts pp(coll)
    expect(show.title).to eq 'The World'

    # idiomatic
    show_i = client.get_show(74)
    expect(show.title).to eq (show_i.title)

  end
end

describe "episodes" do
  it "should fetch episodes" do
    client = get_client
    ep = client.get("/episodes/3431")
    ep_i = client.get_episode(3431)
    expect(ep.title).to eq(ep_i.title)
  end 

  it "should search" do
    client = get_client
    res = client.search('episodes', { q: 'test' })
    expect(res.is_success).to be_truthy
    expect(res.query).to eq 'test'
    expect(res.page).to eq 1
    expect(res.results.size).to eq 10
    res.results.each do |episode|
      printf("[%s] %s (%s)\n", episode.id, episode.title, episode.show_title)
      expect(episode.audio_files.size).to eq 1
    end
  end

end

