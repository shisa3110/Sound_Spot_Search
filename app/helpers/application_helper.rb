module ApplicationHelper
  def default_meta_tags
    {
      site: 'Sound Spot Search',  #サイト名
      title: '音を鳴らせる場所 楽器の練習ができる場所・施設を検索するサービス',
      reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'SoundSpotSearchは楽器の練習等大きな音を鳴らすことのできる場所を地図や一覧から検索するサービスです。',
      keywords: '音楽,楽器,楽器練習,スタジオ,カラオケ,音楽練習室',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,   
      og: {
        site_name: 'Sound Spot Search',
        title: '音を鳴らせる場所 楽器の練習ができる場所・施設を検索するサービス',
        description: 'SoundSpotSearchは楽器の練習等大きな音を鳴らすことのできる場所を地図や一覧から検索するサービスです。', 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      x: {
        card: 'summary_large_image',
        site: '@ss_runteq55b',
        image: image_url('ogp.png')
      }
    }
  end
end
