module R53
  class Account
    module XML
      private
        def change_resource_record_sets_xml(name, changes, options)
          lambda do
            ChangeResourceRecordSetsRequest xmlns: XMLNS do
              Comment options[:comment] if options[:comment]
              ChangeBatch(&change_batch_xml(changes))
            end
          end
        end

        def change_batch_xml(changes)
          lambda do
            changes.each do |action, list|
              Array(list).each { |change| Change(&change_xml(action, change)) }
            end
          end
        end

        def change_xml(action, change)
          lambda do
            Action action.to_s.upcase
            ResourceRecordSet do
              Name change[:name]
              Type change[:type]
              TTL change[:ttl]
              ResourceRecords do
                change[:values].each do |value|
                  ResourceRecord do
                    Value value
                  end
                end
              end
            end
          end
        end

        def create_hosted_zone_xml(name, options)
           lambda do
            CreateHostedZoneRequest xmlns: XMLNS do
               Name name
               CallerReference options[:reference]
               HostedZoneConfig do
                 Comment options[:comment]
               end if options[:comment]
             end
          end
        end
    end
  end
end
